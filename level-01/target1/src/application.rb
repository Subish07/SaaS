# require './department' # Include other files in the same directory
class Department
  attr_accessor :name,:count
  def initialize(dname)
    self.count=0
    self.name=dname
    @SecA=[]
    @SecB=[]
    @SecC=[]
  end
  def sortSec(secname)
    if secname=="A"
      @SecA=@SecA.sort
    elsif secname=="B"
      @SecB=@SecB.sort
    else
      @SecC=@SecC.sort
    end
  end
  def enroll(sname)
    if self.count==30
      return "Error: Seats are not available in #{self.name}"
    else
      sec=""
      roll=0
      if @SecA.length <10
        @SecA<<sname
        sec="A"
        sortSec(sec)
        roll=@SecA.index(sname)
      elsif @SecB.length <10
        sec="B"
        @SecB<<sname
        sortSec(sec)
        roll=@SecA.index(sname)
      else
        sec="C"
        @SecC<<sname
        sortSec(sec)
        roll=@SecA.index(sname)
      end
    end
    msg="You have been enrolled to #{self.name}\nYou have been allotted section #{sec}\nYour roll number is #{self.name[0..2]+sec+(sprintf '%02d',roll+1)}"
    return msg
  end  
  def leave(sname,sec)
    x=""
    if sec=="A"
      @SecA.delete(sname)
    elsif sec=="B"
      @SecB.delete(sname)
    else
      @SecA.delete(sname)
    end
    sortSec(sec)
  end
  def find_sec(sname)
    if @SecA.include? sname
      return "A"
    elsif @SecB.include? sname
      return "B"
    elsif @SecC.include? sname
      return "C"
    else
      return "Name Not Found :("
    end
  end
  def change_sect(sname,current,tosection)
    msg=""
    if tosection=="A" && @SecA.length<=10
      leave(sname,current)
      @SecA<<sname
      sortSec(tosection)
      roll=@SecA.index(sname)
      msg="You have been allotted section #{tosection}\nYour roll number is #{self.name[0..2]+tosection+(sprintf '%02d',roll+1)}"
      return msg
    elsif tosection=="B" && @SecB.length<=10
      leave(sname,current)
      @SecB<<sname
      sortSec(tosection)
      roll=@SecB.index(sname)
      msg=msg="You have been allotted section #{tosection}\nYour roll number is #{self.name[0..2]+tosection+(sprintf '%02d',roll+1)}"
      #msg="\nYou have been enrolled to #{self.name}\nYou have been allotted section #{tosection}\nYour roll number is #{self.name[0..2]+tosection+(sprintf '%02d',@SecB.length)}.\n"
      return msg
    elsif tosection=="C" && @SecC.length<=10
      leave(sname,current)
      @SecC<<sname
      sortSec(tosection)
      roll=@SecC.index(sname)
      msg=msg="You have been allotted section #{tosection}\nYour roll number is #{self.name[0..2]+tosection+(sprintf '%02d',roll+1)}"
      #msg="\nYou have been enrolled to #{self.name}\nYou have been allotted section #{tosection}\nYour roll number is #{self.name[0..2]+tosection+(sprintf '%02d',@SecC.length)}.\n"
      return msg
    else
      return "\nNo Seats"
    end
  end
  def displayallSec()
    return displaySec("A")+displaySec("B")+displaySec("C")
  end
  def displaySec(section)
    msg=""
    if section.upcase=="A"
      i=1
      @SecA.each do |secname|
        roll=self.name[0..2]+"A"+(sprintf '%02d',i)
        msg+="\n#{secname} - #{roll}"
        i=i+1
      end
    elsif section=="B"
      i=1
      @SecB.each do |secname|
        roll=self.name[0..2]+"B"+(sprintf '%02d',i)
        msg+="\n#{secname.downcase} - #{roll}"
        i=i+1
      end
    else section=="C"
      i=1
      @SecC.each do |secname|
        roll=self.name[0..2]+"C"+(sprintf '%02d',i)
        msg+="\n#{secname.downcase} - #{roll}"
        i=i+1
      end
    end
    return msg
  end
  def displayStud(student_name)
    sec=find_sec(student_name)
    roll=self.name[0..2]
    if sec=="A"
      roll=roll+"A"+(sprintf '%02d',@SecA.index(student_name)+1)
    elsif sec=="B"
      roll=roll+"B"+(sprintf '%02d',@SecB.index(student_name)+1)
    else sec=="C"
      roll=roll+"C"+(sprintf '%02d',@SecC.index(student_name)+1)
    end
    msg="#{student_name} - #{self.name} - Section #{sec} - #{roll}"        
    return msg     
  end
end

# Your application
class Application

  def initialize
    ['EEE', 'MECH', 'CSE', 'CIVIL'].each { |dept| Department.new(dept) }
  end

  def enroll(student_name, student_department)
    flag=0
    ObjectSpace.each_object(Department) do |obj|
      if obj.name==student_department.upcase
        flag=1
        return obj.enroll student_name
        break
      end
    end
  end

  def change_dept(student_name, student_department)
    ## write some logic to frame the string below
    flag=0
    ObjectSpace.each_object(Department) do |dept|
      x=dept.find_sec(student_name)
      if x!="Name Not Found :("
        ObjectSpace.each_object(Department) do |dept1|
          if dept1.name==student_department and dept1.count<30
            dept.leave(student_name,x)
            return dept1.enroll(student_name)
            flag=1
            break
          end
        end
        break
      end
    end
  end

  def change_section(student_name, section)
    ## write some logic to frame the string below
    flag=0
    ObjectSpace.each_object(Department) do |dept|
      x=dept.find_sec(student_name)
      if x!="Name Not Found :("
        return dept.change_sect(student_name,x,section.upcase)
        flag=1
        break
      end
    end
    if flag==0
      return "\nStudent not found."
    end
  end

  def department_view(student_dept)
    ## write some logic to frame the string below
    y="List of students:"
    x=""
    ObjectSpace.each_object(Department) do |dept|
      if dept.name == student_dept.upcase
        x=dept.displayallSec()
        break
      end
    end
    return y+x
  end

  def section_view(student_dept, section)
    ## write some logic to frame the string below
    x="List of students:" 
    ObjectSpace.each_object(Department) do |obj|
      if obj.name==student_dept.upcase
        return x+obj.displaySec(section.upcase)
      end
    end
    return x
  end

  def student_details(student_name)
    ## write some logic to frame the string below
    flag=0
    ObjectSpace.each_object(Department) do |dept|
      if dept.find_sec(student_name)!="Name Not Found :("
        return dept.displayStud(student_name)
        flag=1
        break
      end
    end
    if flag==0
      return "\nNo name exists"
    end
  end
end