Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	scope module: :v1 do
  		post 'v1/update',to: "charts#get_event"
		post 'v1/authenticate', to: 'authentication#authenticate' ##using
		put 'v1/google-login', to: 'authentication#google_login' #using
		get 'v1/get-user-details', to: 'users#get_user_detail' #using
		post 'v1/get-roles-user-type', to: 'roles#get_role_by_user_type' #using
		post 'v1/create-user-by-admin', to: 'users#create_user_by_admin' #using
		put 'v1/update-user-by-admin', to: 'users#update_user_by_admin' #using
		get 'v1/get-all-users', to: 'users#get_all_users' #using
		put 'v1/put-user-role', to: 'user_roles#put_by_admin'#using
		post 'v1/create-user-role-by-admin', to: 'user_roles#create_user_role_by_admin'#using
		put 'v1/delete-user-role', to: 'user_roles#delete_user_role' #using
		post 'v1/delete-role-user-by-admin', to: 'role_users#delete_role_user_by_admin'#using
		post 'v1/get-user-related-data', to: 'users#get_user_related_datas'#using
		get 'v1/get-program-module', to: 'programs#get_data_for_program_module' #using
		get 'v1/get-list-of-programs', to: 'programs#get_list_of_programs' #using
		post 'v1/user/registration', to: 'users#create'
		post 'v1/users/show-all', to: 'users#show_user_by_type'
		put 'v1/user/edit', to: 'users#edit'
		post 'v1/cohort/get-user', to: 'users#get_user' #using
		put 'v1/password-reset', to: 'users#password_reset' #using
		put 'v1/password-reset-link', to: 'users#password_reset_link'
		post 'v1/user/direct/registration', to: 'users#direct_registration'
		put 'v1/user/delete-user', to: 'users#delete'
		get 'v1/user-roles', to: 'user_roles#index'
		post 'v1/create-user-role', to: 'user_roles#create'
		post 'v1/edit-user-role', to: 'user_roles#edit'
		post 'v1/delete-user-role', to: 'user_roles#delete'
		post 'v1/create-program-type', to: 'program_types#create' #using
		put 'v1/edit-program-type', to: 'program_types#edit' #using
		get 'v1/show-program-types', to: 'program_types#show'
		post 'v1/delete-program-type', to: 'program_types#delete'#using
		put 'v1/permission/create-default-permissions', to: 'users#create_default_privileges'
		put 'v1/profile/update-user-account', to: 'users#user_profile_update'
		get 'v1/profile/get-user-details', to: 'users#get_user_for_profile'
		###################
		##########Initial Flow controller##########
		post 'v1/program/admin/request-current-form', to: 'initial_flows#request_current_state_form' #using
		post 'v1/gentle-reminder', to: 'initial_flows#reminder_mail_for_current_state' #using
		post 'v1/get-application-current-form-data', to: 'initial_flows#get_application_current_form_data' #using
		post 'v1/startup-accept-by-admin', to: 'initial_flows#startup_accept_by_admin' #using
		post 'v1/startup-accept-by-admin-bulk', to: 'initial_flows#startup_accept_by_admin_bulk' #using
		post 'v1/startup-reject-by-admin', to: 'initial_flows#startup_reject_by_admin' #using
		post 'v1/startup-reject-by-admin-bulk', to: 'initial_flows#startup_reject_by_admin_bulk' #using
		post 'v1/startup-current-state-form-submission', to: 'initial_flows#current_state_form_submit' #using

		#############################################
		###########Contract Flow controller #############3
		get 'v1/get-contract-additional-information', to: 'contract_flows#get_additional_contract_information'#using
		#######startup user registration#########
		post 'v1/user/startup/registration' ,to: 'users#startup_user'
		#########################################
		#######mentor user registration#########
		post 'v1/user/mentor/registration' ,to: 'users#mentor_user'
		#########################################
		#######Grant permission#########
		post 'v1/user/admin-permissions' , to: 'user_roles#grant_access'
		################################
		#########role ##############
		post 'v1/create-role', to: 'roles#create'
		get 'v1/role/show-all', to: 'roles#show_all'
		put 'v1/role/edit', to: 'roles#edit'
		put 'v1/role/delete', to: 'roles#delete'

		############################

		####Program Location######
		post 'v1/create-program-location', to: 'program_locations#create' #using
		put 'v1/edit-program-location', to: 'program_locations#edit' #using
		get 'v1/show-program-locations', to: 'program_locations#show'
		post 'v1/delete-program-location', to: 'program_locations#delete'#using
		###############
		####Program ######
		post 'v1/create-program', to: 'programs#create' #using
		put 'v1/edit-program', to: 'programs#edit'
		get 'v1/show-programs', to: 'programs#show'#using
		get 'v1/contract-manager-programs', to: 'programs#contract_manager_programs' #using
		post 'v1/delete-program', to: 'programs#delete'
		put 'v1/program/assign-application-question-to-program', to: 'programs#assign_application_ques_to_program'
		put 'v1/program/delete-application-question-to-program', to: 'programs#delete_app_ques_from_program'

		####Program Registration Questions######
		post 'v1/create-application-question', to: 'application_questions#create'
		put 'v1/edit-application-question', to: 'application_questions#edit'
		get 'v1/show-application-questions', to: 'application_questions#show'
		put 'v1/show-application-questions-by-program', to: 'application_questions#show_app_ques_by_program'
		post 'v1/show-program-questions', to: 'application_questions#show_ques_related_program'
		put 'v1/delete-application-question', to: 'application_questions#delete'
		post 'v1/create-program-questions-response', to: 'application_questions#application_question_response'#using
		post 'v1/get-program-question-response', to: 'application_questions#get_application_response_questions' #using
		post 'v1/admin-feedback-for-startup-response', to: 'application_questions#app_ques_res_admin' #using
		###############
		####startup Registration Questions######
		post 'v1/create-startup-profile-question', to: 'startup_profile_questions#create'
		put 'v1/edit-startup-profile-question', to: 'startup_profile_questions#edit'
		get 'v1/show-startup-profile-questions', to: 'startup_profile_questions#show'
		post 'v1/delete-startup-profile-question', to: 'startup_profile_questions#delete'
		###############
		###############Startup_registration - program-registration#######
		post 'v1/program/startup-registration', to: 'startup_registrations#create' #using
		post 'v1/program/startup-app-response', to: 'startup_registrations#app_ques_res'
		post 'v1/program/show-startup-program-wise', to: 'startup_registrations#show_registered_startup'#using
		post 'v1/program/show-startup-for-contract', to: 'startup_registrations#show_accetped_startup'
		post 'v1/program/startup-application-details', to: 'startup_registrations#show_all_details'
		post 'v1/program/admin/startup-app-response', to: 'startup_registrations#app_ques_res_admin'
		post 'v1/program/admin/startup-application-status-change' ,to: 'startup_registrations#set_app_status'
		# get 'v1/program/admin/startup-application-accept-list' ,to: 'startup_registrations#show_accept_startup'
		#################################################################

		####################Contract form creation#######################
		post 'v1/program/startup/create-contract', to: 'contract_forms#create_contract_form' 
		put 'v1/program/startup/update-contract', to: 'contract_forms#update_contract_form'
		post 'v1/program/startup/contract-data-for-startup', to: 'contract_forms#show_contract_for_startup' #using
		post 'v1/program/startup/verify-and-approve-contract-form', to: 'contract_forms#contract_approval_by_admin' #using
		post 'v1/program/startup/startup-response-contract', to: 'contract_forms#startup_response_for_contract'
		post 'v1/program/startup/get-contract-form-for-user', to: 'contract_forms#send_contract_details'
		post 'v1/program/startup/contract-form-response', to: 'contract_forms#contract_form_response'
		post 'v1/program/admin/get-approval-contract-form', to: 'contract_forms#get_contract_form_by_approval'
		post 'v1/program/admin/approved-contract-form', to: 'contract_forms#approved_by_admin'
		##################################################################

		######startup profile ###########
		post 'v1/startup/direct-registration', to: 'startup_profiles#direct_registration'
		post 'v1/startup/authentication', to: 'startup_profiles#startup_authenticate'
		post 'v1/startup/show-profile', to: 'startup_profiles#show' #using
		get 'v1/startup/show-startup-profiles', to: 'startup_profiles#show_all'
		put 'v1/user/startup/edit-startup-profile', to: 'startup_profiles#admin_edit'
		post 'v1/startup/delete-startup-profile', to: 'startup_profiles#delete'
		post 'v1/user/startup/delete-startup-profile', to: 'startup_profiles#user_delete'
		post 'v1/program/startup/create-password', to: 'startup_profiles#create_password'
		post 'v1/program/startup-profile/get-details', to: 'startup_profiles#show_all_details_for_startups'
		put 'v1/startup/edit-startup-profile', to: 'startup_profiles#edit' #using
		post 'v1/startup/create-team-member', to: 'startup_profiles#add_team_member'
		put 'v1/startup/edit-team-member', to: 'startup_profiles#edit_team_member'
		put 'v1/startup/delete-team-member', to: 'startup_profiles#delete_team_member'
		post 'v1/startup/show-profiles-for-admin', to: 'startup_profiles#show_profile_created_startups'

		# post 'v1/program/startup-profile/edit', to: 'startup_profiles#edit_startup'
		#################################

		#####################Founding source#######################
		post 'v1/startup-profile/founding-source/create', to: 'founding_sources#create'
		put 'v1/startup-profile/founding-source/edit', to: 'founding_sources#edit'
		put 'v1/startup-profile/founding-source/delete', to: 'founding_sources#delete'

		###########################################################

		################program status########
		post 'v1/create-status', to: 'program_statuses#create'
		get 'v1/show-statuses', to: 'program_statuses#show'
		put 'v1/edit-status', to: 'program_statuses#edit'
		post 'v1/delete-status', to: 'program_statuses#delete'
		######################################

		################startup registration########
		# post 'v1/program/registration', to: 'startup_registrations#create'
		# get 'v1/show-statuses', to: 'program_statuses#show'
		# put 'v1/edit-status', to: 'program_statuses#edit'
		# post 'v1/delete-status', to: 'program_statuses#delete'
		######################################

		################current state form########
		post 'v1/program/create-current-state-form', to: 'current_state_forms#create'
		post 'v1/program/show-current-state-form', to: 'current_state_forms#show'
		post 'v1/program/user/show-current-state-form', to: 'current_state_forms#admin_show' #using
		put 'v1/program/startup/edit-current-state-form', to: 'current_state_forms#edit'
		put 'v1/program/admin/response-current-state-form', to: 'current_state_forms#admin_response' 
		put 'v1/program/admin/edit-current-state-form-admin', to: 'current_state_forms#admin_edit_current_state_form' 
		# post 'v1/delete-status', to: 'program_statuses#delete'
		######################################
		###########road map#############
		post 'v1/program/startup/get-program-road_map-for-startup', to: 'road_maps#get_program_for_startup'
		post 'v1/program/startup/get-road_map-for-startup', to: 'road_maps#get_road_map_for_startup'
		post 'v1/program/startup/get-road_map-for-startup-admin', to: 'road_maps#get_road_map_for_startup_admin'
		post 'v1/program/startup/create-road-map', to: 'road_maps#create'
		post 'v1/program/startup/mobile-create-road-map', to: 'road_maps#create_all_roadmap_milestones_resource'
		post 'v1/program/startup/delete-road-map', to: 'road_maps#delete'
		post 'v1/program/startup/show-road-maps', to: 'road_maps#show_all'
		put 'v1/program/startup/edit-road-map-startup', to: 'road_maps#startup_edit'
		put 'v1/program/startup/edit-road-map-admin', to: 'road_maps#admin_edit'
		###########road map#############

		######Resource Api's###########
		post 'v1/program/startup/request-resource', to: 'resources#create'
		put 'v1/program/startup/request-resource-edit', to: 'resources#edit'
		put 'v1/program/startup/request-resource-get', to: 'resources#get_by_milestone'
		###############################


		########Frameworks#########
		post 'v1/program/create-framework' ,to: 'frameworks#create' #using
		get 'v1/program/show-all-framworks', to: 'frameworks#show_all' #using 
		post 'v1/program/show-framework', to: 'frameworks#show' #using
		put 'v1/program/edit-framework', to: 'frameworks#edit'  #using
		put 'v1/program/delete-framework', to: 'frameworks#delete' #using
		post 'v1/program/merge-courses-with-framework', to: 'frameworks#assign_courses_to_framework' #using
		post 'v1/program/delete-course-with-framework', to: 'frameworks#remove_courses_from_framework' #using
		###########################
		##########courses###############
		get 'v1/framework/course/view-all', to: 'courses#view_all_courses' #using
		post 'v1/framework/course/create-and-update-course', to: 'courses#create_new_course' #using
		post 'v1/framework/course/create-activity', to: 'courses#create_activity' #uisng
		post 'v1/framework/course/delete-activity', to: 'courses#delete_activity' #using
		post 'v1/framework/course/create-update-checklist', to: 'courses#create_checklists' #using
		put 'v1/framework/course/delete-checklist', to: 'courses#delete_checklist' #using

		post 'v1/framework/course/delete-course-activity-and-checklists', to: 'courses#delete_course' #using
		put 'v1/framework/course/assign_activities_to_startup', to: 'courses#assign_activity_to_startups' #using
		put 'v1/framework/course/get-assigned-courses', to: 'courses#get_assigned_courses' #using
		put 'v1/framework/course/get-assigned-courses-for-startup', to: 'courses#get_assigned_courses_for_startup' #using
		put 'v1/framework/course/startup-response-for-activity', to: 'courses#startup_response_for_activity' #using
		put 'v1/framework/course/admin-response-for-activity', to: 'courses#admin_response_for_activity' #using
		put 'v1/framework/course/admin-response-for-checklists', to: 'courses#checklists_response_by_admin' #using
		put 'v1/framework/course/send-reminder', to: 'courses#send_reminder_to_complete_activities' #using

		################################

		##########Activities###########################
		post 'v1/program/framework/create-activity' , to: 'activities#create'
		get 'v1/program/framework/show-all-activities', to: 'activities#show_all'
		post 'v1/program/framework/show-activity', to: 'activities#show' 
		put 'v1/program/framework/edit-activity', to: 'activities#edit' 
		put 'v1/program/framework/delete-activity', to: 'activities#delete'
		post 'v1/program/framework/create-activity-and-checklists', to: 'activities#activity_and_checklists_create' #using
		put 'v1/program/framework/update-activity-and-checklists', to: 'activities#activity_and_checklists_update' #using
 
		##############################
		

		################checklists###########################
		post 'v1/program/framework/activity/create-checklist' , to: 'checklists#create'
		get 'v1/program/framework/activity/show-all-checklists', to: 'checklists#show_all'
		post 'v1/program/framework/activity/show-checklist', to: 'checklists#show' 
		put 'v1/program/framework/activity/edit-checklist', to: 'checklists#edit' 
		put 'v1/program/framework/activity/delete-checklist', to: 'checklists#delete' #using 
		###################################

		######Activity response##############
		post 'v1/program/framework/activity/create-activity-response', to: 'activity_responses#create'
		put 'v1/program/framework/activity/rating-activity-response', to: 'activity_responses#rating_by_admin'
		post 'v1/program/framework/activity/show-activity-response', to: 'activity_responses#show_all'
		#####################################

		###############StartupEnquires###############
		post 'v1/program/startup-registration/queries', to: 'authentication#contract_quiries_to_admin'

		################Chart API############
		get 'v1/chart/get-program-chart', to: 'charts#get_program_startups'
		get 'v1/chart/get-event', to: 'charts#get_event'
		##############session Apis###############
		post 'v1/program/create-session', to: 'sessions#create'
		put 'v1/program/edit-session', to: 'sessions#edit'
		put 'v1/program/delete-session', to: 'sessions#delete'
		put 'v1/program/get-session-by-program', to: 'sessions#program_session_show'
		put 'v1/program/get-session-attendees', to: 'sessions#show_session_attendees'
		put 'v1/program/assign-attendess-for-session', to: 'sessions#assign_attendees_to_session'
		put 'v1/program/get-sessions-for-startup', to: 'sessions#show_sessions_to_startups'
		put 'v1/program/get-programs-related-users', to: 'sessions#get_program_related_users'
		put 'v1/program/remove-attendee-from-session', to: 'sessions#delete_attendees_from_session'
		put 'v1/program/update-invite', to: 'sessions#update_invite'
		###########################################news Feed
		post 'v1/program/create-news-feed', to: 'news_feeds#create_news_feed'
		put 'v1/program/update-news-feed', to: 'news_feeds#update_news_feed'
		put 'v1/program/delete-news-feed', to: 'news_feeds#delete_news_feed'
		put 'v1/program/show-news-feeds', to: 'news_feeds#show_program_related_news_feed'
		######################################news Feed Comments
		post 'v1/program/create-news-feed-comment', to: 'news_feeds#create_comment_for_feed'
		put 'v1/program/update-news-feed-comment', to: 'news_feeds#update_comment_for_feed'
		put 'v1/program/delete-news-feed-comment', to: 'news_feeds#delete_comment_for_feed'
		put 'v1/program/show-news-feeds-comments', to: 'news_feeds#show_comment_for_feed'
		##################################################
		# put 'v1/trigger/pusher/news-feed',to: "news_feeds#trigger_pusher_event"

		mount ActionCable.server => '/cable'
	end

end
