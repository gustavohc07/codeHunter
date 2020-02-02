# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')
job = Job.create(title: 'Programador React',
                 level: 'Júnior',
                 number_of_vacancies: 4,
                 salary: 3500,
                 description: 'Programador Ruby on Rails para atuar em startup',
                 abilities: 'CRUD, Git, Ruby, Ruby on Rails, Boa comunicação',
                 deadline: '20/01/2020',
                 start_date: '02/01/2020',
                 location: 'Remoto',
                 contract_type: 'CLT',
                 headhunter: headhunter)

