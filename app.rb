require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/employee")
require("./lib/division")
require("pg")
require('pry')

get('/') do
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

post('/') do
  division = Division.create({:name => params["division_name"]})
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

get('/employee_edit/:id') do
  @employee = Employee.find(params.fetch("id").to_i())
  @division = @employee.division()
  erb(:employee_edit)
end

patch("/employee_edit/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @employees = Employee.all()
  erb(:index)
end

get('/division/:id') do
  @division = Division.find(params.fetch("id").to_i())
  @employees = @division.employees()
  # same as:
  # @employees = Employee.where(division_id: @division.id)
  erb(:division)
end

post("/division/:id") do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @employee = Employee.create(:name => params.fetch('name'), :division_id => @division.id)
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

get('/division_edit/:id') do
  @division = Division.find(params.fetch("id").to_i())
  @employees = Employee.all()
  erb(:division_edit)
end

patch("/division_edit/:id") do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i())
  @division.update({:name => name})
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end
