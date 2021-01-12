namespace :dev do
  desc "Configura o ambiente de dev"
  task setup: :environment do
    %x(rails db:drop db:create db:migrate)
    puts "Tipos Cadastrando contatos..."

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos Contatos cadastrados com sucesso"

    ###################

    puts "Cadastrando contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.days.ago, 18.days.ago),
        kind:  Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso"

    ###################

    puts "Cadastrando telefones..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        Phone.create!(number:Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
    puts "Telefones cadastrados com sucesso"

    ####################

    puts "Cadastrando endereços"
    Contact.all.each do |contact|
      address = Address.create(city:Faker::Address.city, street:Faker::Address.street_name, contact: contact)
    end
    puts "Endereços cadastrados com sucesso"
  end
end
