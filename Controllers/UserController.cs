using APIWebService.Models;
using APIWebService.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Security.Claims;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using APIWebService.Data.Entities;
using APIWebService.Models;
using APIWebService.Utilities;
using APIWebService.Repository.Interfaces;

namespace APIWebService.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly UserManager<ApplicationUser> applicationUser;
        private readonly IUserRepository userRepository;
        private readonly ModelUserData userData;
        private readonly IConfiguration configuration;

        /// <summary>All methods for generate authorizations for user account</summary>
        public UserController(IUserRepository userRepository, IHttpContextAccessor httpContextAccessor, IConfiguration configuration, UserManager<ApplicationUser> applicationUser /*,ICollaboratorRepository collaboratorRepository, IOrganizationRepository organizationRepository,*/ )
        {
            this.userRepository = userRepository;
            this.configuration = configuration;
            //this.organizationRepository = organizationRepository;
            this.applicationUser = applicationUser;
            //this.collaboratorRepository = collaboratorRepository

            if (httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.UserData) != null)
            {
                userData = JsonSerializer.Deserialize<ModelUserData>(httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.UserData).Value);
            }
        }

        [HttpPost("SignIn")]
        public async Task<ActionResult<UserToken>> SignIn([FromBody] UserModel user)
        {
            var userInfo = await userRepository.GetUserByEmail(user.email);
            var dataUser = await userRepository.GetUser(userInfo.ID);
            if (dataUser.terms_conditions == (int)Enums.UserTermsConditions.Rejected)
            {
                return BadRequest(new ErrorResponse
                {
                    code = "AU-007",
                    error = "Terms And Conditions Not Accepted"
                });
            }

            var emailconfirmed = await applicationUser.FindByEmailAsync(user.email);
            if (emailconfirmed == null)
            {
                return BadRequest(new ErrorResponse
                {
                    code = "AU-003",
                    error = "Email does not exist"
                });
            }
            if (emailconfirmed.EmailConfirmed == false)
            {
                return BadRequest(new ErrorResponse
                {
                    code = "AU-004",
                    error = "Email not confirmed"
                });
            }
            if (userInfo.status == (int)Enums.UserStatus.Enable || userInfo.status == (int)Enums.UserStatus.ChangePassword)
            {
                var result = await userRepository.Login(user);
                if (result.succeeded)
                {
                    if (dataUser.login_failed > 0 & dataUser.login_failed < 4)
                    {
                        await userRepository.LoginFailedCount(dataUser, true);
                    }
                    if (dataUser.status == (int)Enums.UserStatus.ChangePassword)
                    {
                        result.changePasswordRequired = true;
                        return Ok(result);
                    }
                    return Ok(result);
                }
                else
                {
                    if (await userRepository.LoginFailedCount(dataUser, false) == 2)
                    {
                        return BadRequest(new ErrorResponse
                        {
                            code = "AU-008",
                            error = "Account Block too many failed logins, need to change the password"
                        });
                    }
                    else
                    {
                        return BadRequest(new ErrorResponse
                        {
                            code = "AU-005",
                            error = "Wrong email or password"
                        });
                    }
                }
            }
            else
            {
                await userRepository.LoginFailedCount(dataUser, false);
                return BadRequest(new ErrorResponse
                {
                    code = "AU-006",
                    error = "User not exist"
                });
            }
        }

        [HttpGet]
        public IEnumerable<WeatherForecast> Get()
        {
            var rng = new Random();
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
