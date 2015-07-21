require 'sinatra/base'

class FakeLessonly < Sinatra::Base
  resources = %w(users groups courses lessons)

  resources.each do |resource|
    get "/api/v1/#{resource}" do
      json_response 200, "get_#{resource}.json"
    end

    get "/api/v1/#{resource}/:resource_id" do
      json_response 200, "get_#{resource}_#{params[:resource_id]}.json"
    end

    put "/api/v1/#{resource}/:resource_id" do
      json_response 204, "put_#{resource}_#{params[:resource_id]}.json"
    end
  end

  get '/api/v1/courses/:course_id/assignments' do
    json_response 200, "get_courses_#{params[:course_id]}_assignments.json"
  end

  put '/api/v1/courses/:course_id/assignments' do
    json_response 204, "put_courses_#{params[:course_id]}_assignments.json"
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
