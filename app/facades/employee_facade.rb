
class EmployeeFacade
  def self.fetch_all(page = nil)
    EmployeeService.fetch_all(page)
  end

  def self.fetch(id)
    EmployeeService.fetch(id)
  end

  def self.create(params)
    EmployeeService.create(params)
  end
  
  def self.update(id, params)
    EmployeeService.update(id, params)
  end
end