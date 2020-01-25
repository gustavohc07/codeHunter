FactoryBot.define do
  factory :job do
    title { "Programador RoR" }
    level { "Júnior" }
    number_of_vacancies { 4 }
    salary { 3500 }
    description { "Programador Ruby on Rails para atuar em startup" }
    abilities { "CRUD, Git, Ruby, Ruby on Rails, Boa comunicação" }
    deadline { "20/01/2020" }
    start_date { "02/01/2020" }
    location { "Remoto" }
    contract_type { "CLT" }
  end
end