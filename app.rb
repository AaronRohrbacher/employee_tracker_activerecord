require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/employee")
require("./lib/division")
require("pg")
require('pry')

get('/') do
  @employees = Employee.all()
  erb(:index)
end

post('/') do
  employee = Employee.create({:name => params["name"]})
  @employees = Employee.all()
  erb(:index)
end

get('/employee_edit/:id') do
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee_edit)
end

patch("/employee_edit/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @employees = Employee.all()
  erb(:index)
end
