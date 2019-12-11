require 'sinatra'
require "sinatra/namespace"

class Department
    @@department = [
        { id: "11", name: "HR" },
        { id: "22", name: "IT" },
        { id: "32", name: "Finance" }
    ]

    def self.all
        @@department
    end

    def self.find(department_id)
        @@department.select { |p| p[:id] == department_id }.first
    end
end

set :bind, '0.0.0.0'

# /heathcheck
get '/healthcheck' do
    'Healthy!!!'
end

namespace '/api/containertwo' do

    before do
        content_type 'application/json'
    end

    # /api/containertwo/department
    get '/department' do
        Department.all.to_json
    end

    # /api/containertwo/:id
    get '/department/:id' do
        if (department = Department.find(params[:id])) != nil
            department.to_json
        else
            halt(404, { message:'department Not Found'}.to_json)
        end
    end

end
