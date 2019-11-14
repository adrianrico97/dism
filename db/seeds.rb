# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creamos algúns datos de exemplo cos que poderemos logo probar a aplicación
acc = Account.create!(:description => "Conta de Proba")

u = User.create!(:login => "usuario.proba", :password => "abc123.", :email => "proba@email.com", 
  :name => "Roberto", :surname_1 => "Pérez", :surname_2 => "García", :id_document_number => "11111111H",
  :rol => ROLES[:admin], :active => true, :account => acc)

prog = Program.create!(:description => "Sublime Text", :version => "3.0", 
  :observations => "Non ten licencia", :account => acc)
prog2 = Program.create!(:description => "Microsoft Office 2016", :version => "2016", 
  :observations => "Prezo de licencia: 100€", :account => acc)

brand = Brand.create!(:description => "Lenovo", :account => acc)

model = Model.create(:description => "B50-10", :brand => brand)

device = Device.create!(:description => "Ordenador portátil", :observations => "Cor negra.", :serial_number => "N2019C1234",
:code => "0001", :category => CATEGORIES[:computer], :price => 299.90, :purchase_date => Date.parse('03/05/2018'),
:account => acc, :model => model, :brand => brand)
device.programs << prog
device.programs << prog2

device.associate_user(u)