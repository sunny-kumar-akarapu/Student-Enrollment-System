Role.destroy_all
User.delete_all
Course.delete_all
Enrollment.delete_all

Role.create!([{
  id: 1,
  name: "Admin"
},
{
  id: 2,
  name: "Instructor"
},
{
    id: 3,
    name: "Student"
}])

p "Created #{Role.count} roles"


#run "rails db:seed"

    users=User.create({email: 'admin@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'admin', department: 'Null', number: 'Null', dob: 'Null', major: 'Null', role_ids: 1})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 't1@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'instructor1', department: 'CSC', number: '1112223333', dob: '18-05-1998', major: 'Null', role_ids: 2})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end
    users=User.create({email: 't2@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'instructor2', department: 'ECE', number: '1112223344', dob: '28-05-1998', major: 'Null', role_ids: 2})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 't3@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'instructor3', department: 'EEE', number: '1112223456', dob: '23-05-1998', major: 'Null', role_ids: 2})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 't4@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'instructor4', department: 'CIVIL', number: '1112223334', dob: '17-05-1998', major: 'Null', role_ids: 2})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's1@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student1', department: 'CSC', number: '1122334455', dob: '02-05-1998', major: 'Computer Science', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end


    users=User.create({email: 's2@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student2', department: 'ECE', number: '1112223478', dob: '04-05-1998', major: 'Electrical Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's3@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student3', department: 'CIVIL', number: '1118923478', dob: '06-05-1998', major: 'Civil Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end  


    users=User.create({email: 's4@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student4', department: 'MECHANICAL', number: '1116223478', dob: '08-05-1998', major: 'Mechanical Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's5@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student5', department: 'CHEMICAL', number: '1114523478', dob: '10-06-1998', major: 'Chemical Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's6@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student6', department: 'CSC', number: '1812223478', dob: '12-03-1998', major: 'Computer Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's7@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student7', department: 'NANO', number: '1548923478', dob: '08-05-2000', major: 'Nano Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's8@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student8', department: 'CSC', number: '1112457878', dob: '14-08-1998', major: 'Computer Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's9@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student9', department: 'STATS', number: '1112223478', dob: '04-06-1998', major: 'Statistical Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end

    users=User.create({email: 's10@ncsu.edu', password: 'password', password_confirmation: 'password', name: 'student10', department: 'CSC', number: '1152723478', dob: '28-11-1998', major: 'Computer Engineering', role_ids: 3})

    if users.valid?
      users.save()

    elsif users.errors.any?
      users.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "*NOT VALID*"
    end
