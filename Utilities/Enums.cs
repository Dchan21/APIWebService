namespace Wellness_SDK.Utilities
{
    public class Enums
    {
        public enum Gender
        {
            Undefined = 0,
            Male = 1,
            female = 2
        }
        /******************************************************************User***************************************************************************/
        public enum UserStatus
        {
            Disabled = 0,
            Enable = 1,
            Preregister = 2,
            ChangePassword = 3
        }
        public enum UserRole
        {
            SuperAdmin = 0,
            Admin = 1,
            Coach = 2,
            OrganizationAdmin = 3,
            User = 4
        }
        public enum UserTermsConditions
        {
            Rejected = 0,
            Accepted = 1,
        }

        public enum UserType
        {
            Admin = 0,
            Collaborator = 1,
            Organization = 2,
            Coach = 3,
            Person = 4
        }
        public enum Language
        {
            English = 0,
            Spanish = 1
        }
        /******************************************************************Localization-Identification***************************************************************************/
        public enum LocalizationIdentificationEntity
        {
            Organization = 0,
            BasicInformation = 1
        }
        /******************************************************************Course***************************************************************************/
        public enum CourseFeature
        {
            Normal = 0,
            Feature = 1
        }
        public enum CourseCertificate
        {
            No = 0,
            Yes = 1
        }
        public enum CourseLevel
        {
            Begginer = 0,
            Intermediate = 1,
            Advance = 2
        }
        public enum CourseStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum OrganizationCourseType
        {
            Suggested = 0,
            Required = 1
        }
        public enum OrganizationCourseStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum CourseUserStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum CourseModuleStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum CourseSchedule
        {
            No = 0,
            Yes = 1
        }
        /******************************************************************subscription***************************************************************************/
        public enum subscriptionType
        {
            Organization = 0,
            Individual = 1,
            Family = 2
        }
        public enum subscriptionStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum subscriptionUserStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Module***************************************************************************/
        public enum ModuleStatus
        {
            Disabled = 0,
            Enable = 1
        }
        public enum ModuleVideoStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Module_Progress***************************************************************************/
        public enum ModuleProgressStatus
        {
            Incomplete = 0,
            Completed = 1
        }

        /******************************************************************Video***************************************************************************/
        public enum VideoReturn
        {
            None = 0,
            OnlyTitle = 1,
            FullDetail = 2

        }
        public enum VideoStatus
        {
            Disabled = 0,
            Enable = 1
        }

        public enum VideoType
        {
            Video = 0,
            Live = 1,
            LiveCall = 2
        }
        /******************************************************************Video_Progress***************************************************************************/

        public enum VideoProgressStatus
        {
            Incomplete = 0,
            Completed = 1
        }
        /******************************************************************Material***************************************************************************/
        public enum MaterialType
        {
            Theory = 0,
            Practice = 1,
            Extra = 2,
            Podcast = 3,
            Live = 4,
            Meeting = 5,
            Document=6

        }
        public enum MaterialExtension
        {
            Image = 0,
            Excel = 1,
            Audio = 2,
            Video = 3,
            Meeting = 4,
            Podcast = 5,
            Word=6,
            PowerPoint=7,
            PDF=8,
            PlainText=9,
            Url=10
        }
        public enum MaterialDownload
        {
            No = 0,
            Yes = 1
        }
        public enum MaterialStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Category***************************************************************************/

        public enum CategoryStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Comments***************************************************************************/
        public enum EntityType
        {
            Course = 0,
            Module = 1,
            Video = 2,
            Material = 3
        }
        public enum CommentStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Organization***************************************************************************/
        public enum OrganizationType
        {

        }
        public enum OrganizationStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Collaborator***************************************************************************/
        public enum CollaboratorStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Administrator***************************************************************************/
        public enum AdministratorStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /* public enum 
         {
             
         } */
        /******************************************************************Department***************************************************************************/
        public enum DepartmentStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Team***************************************************************************/
        public enum Teamtatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Identification***************************************************************************/
        public enum IdentificationType
        {
            Identification_Card = 0,
            Legal_Certificate = 1,
            Passport = 2
        }
        /******************************************************************Personal Information***************************************************************************/
        public enum CivilStatus
        {
            Single = 0,
            Married = 1,
            Divorced = 2
        }
        public enum BloodType
        {
            none = 0,
            A = 1,
            B = 2,
            AB = 3,
            O = 4,
            AN = 5,
            BN = 6,
            ABN = 7,
            ON = 8

        }
        /******************************************************************Role***************************************************************************/
        public enum RoleStatus
        {
            Disabled = 0,
            Enable = 1
        }
        /******************************************************************Position***************************************************************************/
        public enum PositionStatus
        {
            Disabled = 0,
            Enable = 1
        }

         /******************************************************************Email***************************************************************************/
        public enum EmailTemplateStatus
        {
            Disabled = 0,
            Enable = 1
        }

        public enum EmailTemplateLanguage
        {
            English = 0,
            Spanish = 1
        }

        public enum EmailTemplateIsHTML
        {
            No = 0,
            Yes = 1
        }

        public enum EmailSendEntityType
        {
            Collaborator = 0,
            User_id = 1,
        }

        public enum EmailSendStatus
        {
            Pending = 0,
            Success = 1,
            Fail = 2
        }
        /******************************************************************Category***************************************************************************/
        /******************************************************************Appointment***************************************************************************/
        public enum AppointmentType
        {
            First = 0,
            Anthropometric = 1,
            MedicalInformation = 2,
            Diet = 3,
            BiochemicalInformation = 4,
            LifeStyle = 5
        }
        public enum MeetingType
        {
            InPerson = 0,
            Online = 1,
            Phone = 2
        }
        public enum AppointmentStatus
        {
            WaitingAppointment = 0,
            InProgress = 1,
            Finished = 2
        }
    }
}