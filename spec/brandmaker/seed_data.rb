# encoding: utf-8

module Brandmaker
  module SeedData

    def main_job_data
      {
        :processing_time=>"0",
        :success=>true,
        :desriptions=> {
          :creator=>"Screenconcept",
          :id=>"8193",
          :topic_name=>"Job",
          :type_name=>"screenconcept__hauptjob",
          :variable=> [
            {
              :technical_name=>"WorkflowOverdueDate",
              :value=> '20.04.2015',
              :variable_type_id=>"-115"
            },
            {
              :technical_name=>"default_media",
              :value=> 'Some Value',
              :variable_type_id=>"-2008"
            },
            {
              :technical_name=>"medienobjektauswahl",
              :value=>"7961,7270",
              :variable_type_id=>"11111"
            },
            {
              :technical_name=>"email_field1",
              :value=>"test@test.com",
              :variable_type_id=>"11112"
            },
            {
              :technical_name=>"email_field2",
              :value=>"Email Subject",
              :variable_type_id=>"11113"
            },
            {
              :technical_name=>"email_field3",
              :value=>"Email message",
              :variable_type_id=>"11114"
            },
            {
              :sub_jobs=> {
                :sub_job=> {
                  :creator=>"Screenconcept",
                  :id=>"8194",
                  :topic_name=>"Job",
                  :type_name=>"screenconcept__subjob",
                  :variable=> [
                    {
                      :technical_name=>"WorkflowOverdueDate",
                      :value=>nil,
                      :variable_type_id=>"-115"
                    },
                    {
                      :technical_name=>"default_media",
                      :value=>nil,
                      :variable_type_id=>"-2008"
                    },
                  ],
                :workflow_step_name=>"Start",
                :workflow_type_name=>"Screenconcept - Testworkflow"
                }
              },
            :technical_name=>"SubJobs",
            :value=>nil,
            :variable_type_id=>"-105"
          },
          grid_variable_data,
          {
            :technical_name=>"TaskManager",
            :value=>nil,
            :variable_type_id=>"11047"
          },
        ],
        :workflow_step_name=>"Start",
        :workflow_type_name=>"Screenconcept - Testworkflow"
        }
      }
    end

    def grid_variable_data
      {
        :grid=>
          {
            :row=>
              [{
                :id=>"7898",
                :topic_name=>"Job",
                :variable=>
                {
                  :technical_name=>"emailadresse",
                  :value=>"Immanuel",
                  :variable_type_id=>"11247"
                }
              },
              {
                :id=>"7899",
                :topic_name=>"Job",
                :variable=>
                {
                  :technical_name=>"emailadresse",
                  :value=>"Michi",
                  :variable_type_id=>"11247"
                }
              }
            ]
          },
        :technical_name=>"email_selection",
        :value=>nil,
        :variable_type_id=>"11245"
      }
    end

    def grid_variable_single_row_data
      {
        :grid=>
          {
            :row=>
              {
                :id=>"7898",
                :topic_name=>"Job",
                :variable=>
                {
                  :technical_name=>"emailadresse",
                  :value=>"Immanuel",
                  :variable_type_id=>"11247"
                }
              }
          },
        :technical_name=>"email_selection",
        :value=>nil,
        :variable_type_id=>"11245"
      }
    end

    def grid_variable_email_data
      {
        :grid=>
          {
            :row=>
              [{
                :id=>"7898",
                :topic_name=>"Job",
                :variable=>
                {
                  :technical_name=>"emailadresse",
                  :value=>"Immanuel (immanuel.haeussermann@screenconcept.ch)",
                  :variable_type_id=>"11247"
                }
              },
              {
                :id=>"7899",
                :topic_name=>"Job",
                :variable=>
                {
                  :technical_name=>"emailadresse",
                  :value=>"Michi (michael.friedli@gateb.com)",
                  :variable_type_id=>"11247"
                }
              }
            ]
          },
        :technical_name=>"email_selection",
        :value=>nil,
        :variable_type_id=>"11245"
      }
    end

    def custom_structure_all_data
      {:find_all_custom_structures_response=>
      {:return=>
        {:processing_time=>"0",
         :success=>true,
         :custom_structures=>
          [
            custom_structure_external_suppliers_data
          ]}}}
    end

    def custom_structure_all_empty_data
      {:find_all_custom_structures_response=>
      {:return=>
        {:processing_time=>"0",
         :success=>true,
         :custom_structures=>
          []}}}
    end

    def custom_structure_external_suppliers_data
      {:label=>"PM_ExterneSuppliers_Druckereien",
            :name=>"PM_ExterneSuppliers_Druckereien",
            :objects=>
             [{:label=>"Demo Druck (immanuel.haeussermann@screenconcept.ch)",
               :name=>"Demo Druck"},
              {:label=>"Demo Druck 2 (michael.friedli@gateb.com)",
               :name=>"Demo Druck 2"}
              ]}
    end

  end
end
