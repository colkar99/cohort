module V1
	 class ChartsController < ApplicationController
	 	skip_before_action :authenticate_request
	 	# skip_before_action :authenticate_request, only: [:direct_registration,:startup_authenticate,:show ,:edit, :delete]
	 	# before_action  :current_user, :get_module
	
		def get_program_startups
			result = {chart: {
					      caption: "Registered startup program wise",
					      subCaption: "",
					      xAxisName: "Programs",
					      yAxisName: "Startup Registrations",
					      numberSuffix: "",
					      theme: "fusion",
					      rotateValues: "0"
					      },
					data: [],
					linkeddata: []
					} 
			startup = 0
			programs = Program.all
			programs.each do |program|
				changed_program_title = ActionView::Base.full_sanitizer.sanitize(program.title)
				changed_program_description = ActionView::Base.full_sanitizer.sanitize(program.description)
				startup = program.startup_registrations.count
				value = {label: changed_program_title,value: startup,link: "newchart-xml-#{changed_program_title}"}
				result[:data].push(value);
				program_registred = 0
				accepted = 0
				rejected = 0
				reviews_pending_by_admin = 0
				reviews_completed = 0
				current_state_initialized = 0
				current_state_submitted = 0
				current_state_reviewed = 0
				contract_form_received = 0
				contract_form_signed_wait_for_app = 0
				startup_profile_created = 0
				road_map_drafted = 0
				program.startup_registrations.each do |startup_reg|
					if startup_reg.application_status == "AA"
						accepted += 1
					elsif startup_reg.application_status == "AR"
						rejected += 1
					elsif startup_reg.application_status == "RP"
							reviews_pending_by_admin += 1
					elsif startup_reg.application_status == "RC"
							reviews_completed += 1
					elsif startup_reg.application_status == "CSFI"
						current_state_initialized += 1
					elsif startup_reg.application_status == "CSFS"
						current_state_submitted += 1
					elsif startup_reg.application_status == "CSFR"
						current_state_reviewed += 1
					elsif startup_reg.application_status == "CFR"
								contract_form_received += 1
					elsif startup_reg.application_status == "CSWFP"
						contract_form_signed_wait_for_app += 1
					elsif startup_reg.application_status == "SPC"
						startup_profile_created += 1
					elsif startup_reg.application_status == "RMD"
						road_map_drafted += 1
					elsif startup_reg.application_status == "PR"
						program_registred += 1
					else

					end																
				end
				pieChart = {id: changed_program_title,linkedchart:{
					                chart: {
                  						caption: changed_program_description,
					                    subcaption: "Last year",
					                    numberprefix: "",
					                    theme: "fusion",
					                    plottooltext: "$label, $dataValue,  $percentValue"
					                },
					                data: [
					                    {
					                        label: "Accepted",
					                        value: accepted
					                    },
					                    {
					                        label: "Rejected",
					                        value: rejected
					                    },
					                    {
					                        label: "Road map drafted",
					                        value: road_map_drafted
					                    },
					                    {
					                        label: "Application Registered",
					                        value: program_registred
					                    },
					                    {
					                        label: "Reviews pending by admin",
					                        value: reviews_pending_by_admin
					                    },
					                    {
					                        label: "Reviews completed",
					                        value: reviews_completed
					                    },
					                    {
					                        label: "Current state form initialized",
					                        value: current_state_initialized
					                    },
					                    {
					                        label: "Current state form submitted",
					                        value: current_state_submitted
					                    },
					                    {
					                        label: "Current state form reviewed by admin",
					                        value: current_state_reviewed
					                    },
					                    {
					                        label: "Contract form received by startup",
					                        value: contract_form_received
					                    },
					                    {
					                        label: "Startup signed contract wainting for approval",
					                        value: contract_form_signed_wait_for_app
					                    },
					                    {
					                        label: "Startup Profile created",
					                        value: startup_profile_created
					                    },
					                    {
					                        label: "Road map drafted by startup",
					                        value: road_map_drafted
					                    }
					                ]
					            }
				}
				result[:linkeddata].push(pieChart) 
			end
			render json: result,status: :ok
		end

		def get_event
			event = [{title: "Event no 1", start: '2019-03-05T01:00:00+05:30'},{title: "Event no 6", start: '2019-03-06T01:00:00+05:30'}]
			render json: event, status: :ok
		end


	 end
end

# {
#     "chart": {
#         "caption": "Top 3 Juice Flavors",
#         "subcaption": "Last year",
#         "xaxisname": "Flavor",
#         "yaxisname": "Amount (In USD)",
#         "numberprefix": "$",
#         "theme": "fusion",
#         "rotateValues": "0"
#     },
#     "data": [
#         {
#             "label": "Apple",
#             "value": "810000",
#             "link": "newchart-xml-apple"
#         },
#         {
#             "label": "Cranberry",
#             "value": "620000",
#             "link": "newchart-xml-cranberry"
#         },
#         {
#             "label": "Grapes",
#             "value": "350000",
#             "link": "newchart-xml-grapes"
#         }
#     ],
#     "linkeddata": [
#         {
#             "id": "apple",
#             "linkedchart": {
#                 "chart": {
#                     "caption": "Apple Juice - Quarterly Sales",
#                     "subcaption": "Last year",
#                     "numberprefix": "$",
#                     "theme": "fusion",
#                     "rotateValues": "0",
#                     "plottooltext": "$label, $dataValue,  $percentValue"
#                 },
#                 "data": [
#                     {
#                         "label": "Q1",
#                         "value": "157000"
#                     },
#                     {
#                         "label": "Q2",
#                         "value": "172000"
#                     },
#                     {
#                         "label": "Q3",
#                         "value": "206000"
#                     },
#                     {
#                         "label": "Q4",
#                         "value": "275000"
#                     }
#                 ]
#             }
#         },
#         {
#             "id": "cranberry",
#             "linkedchart": {
#                 "chart": {
#                     "caption": "Cranberry Juice - Quarterly Sales",
#                     "subcaption": "Last year",
#                     "numberprefix": "$",
#                     "theme": "fusion",
#                     "plottooltext": "$label, $dataValue,  $percentValue"
#                 },
#                 "data": [
#                     {
#                         "label": "Q1",
#                         "value": "102000"
#                     },
#                     {
#                         "label": "Q2",
#                         "value": "142000"
#                     },
#                     {
#                         "label": "Q3",
#                         "value": "187000"
#                     },
#                     {
#                         "label": "Q4",
#                         "value": "189000"
#                     }
#                 ]
#             }
#         },
#         {
#             "id": "grapes",
#             "linkedchart": {
#                 "chart": {
#                     "caption": "Grapes Juice - Quarterly Sales",
#                     "subcaption": "Last year",
#                     "numberprefix": "$",
#                     "theme": "fusion",
#                     "rotateValues": "0",
#                     "plottooltext": "$label, $dataValue,  $percentValue"
#                 },
#                 "data": [
#                     {
#                         "label": "Q1",
#                         "value": "45000"
#                     },
#                     {
#                         "label": "Q2",
#                         "value": "72000"
#                     },
#                     {
#                         "label": "Q3",
#                         "value": "95000"
#                     },
#                     {
#                         "label": "Q4",
#                         "value": "108000"
#                     }
#                 ]
#             }
#         }
#     ]
# }
     

######activity params########

# t.string "name"
#     t.text "description"
#     t.text "placeholder"
#     t.integer "order"
#     t.integer "framework_id"
#     t.integer "created_by"
#     t.boolean "isActive", default: true
#     t.boolean "isDelete", default: false
#     t.integer "deleted_by"
#     t.datetime "deleted_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["framework_id"], name: "index_activities_on_framework_id"
	

	       #  {
        #     id: "apple",
        #     linkedchart: {
        #         chart: {
        #             caption: "Apple Juice - Quarterly Sales",
        #             subcaption: "Last year",
        #             numberprefix: "$",
        #             theme: "fusion",
        #             rotateValues: "0",
        #             plottooltext: "$label, $dataValue,  $percentValue"
        #         },
        #         data: [
        #             {
        #                 label: "Q1",
        #                 value: "157000"
        #             },
        #             {
        #                 label: "Q2",
        #                 value: "172000"
        #             },
        #             {
        #                 label: "Q3",
        #                 value: "206000"
        #             },
        #             {
        #                 label: "Q4",
        #                 value: "275000"
        #             }
        #         ]
        #     }
        # }