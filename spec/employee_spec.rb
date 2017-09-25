require("spec_helper")

describe(Employee) do

  describe("#employees") do
    it("checks to see if employees are created") do
      test_employee1 = Employee.create({:name => "employee1"})
     expect(Employee.all()).to(eq([test_employee1]))
    end
  end

  describe("#division") do
    it("tells which division it belongs to") do
      test_division = Division.create({:name => "division"})
      test_employee = Employee.create({:name => "employee", :division_id => test_division.id})
      expect(test_employee.division()).to(eq(test_division))
    end
  end
end
