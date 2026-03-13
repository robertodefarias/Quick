puts "Cleaning seed trip..."

Trip.where(user_id: nil).destroy_all

puts "Creating seed trips..."

Trip.create!(
  city: "Rio de Janeiro",
  content: <<~TEXT,
    Bem-vindo! Aqui está um guia rápido para visitar o Rio de Janeiro:

  ## Atrações
  - Cristo Redentor
  - Pão de Açúcar
  - Praia de Copacabana
  - Bairro de Santa Teresa

  ## Gastronomia
  - Feijoada
  - Pão de queijo
  - Frutos do mar frescos
  - Caipirinha

  ## Bairros
  - Copacabana
  - Ipanema
  - Santa Teresa
  - Lapa

  ## Dicas
  - Melhor época para visitar: maio a outubro
  - Assista ao pôr do sol no Arpoador
  - Use Uber ou aplicativos de transporte à noite

  Pergunte-me qualquer coisa sobre atrações, gastronomia ou dicas de viagem!
  TEXT
  image_url: "https://images.unsplash.com/photo-1483729558449-99ef09a8c325"
)

Trip.create!(
  city: "São Paulo",
  content: <<~TEXT,
    Bem-vindo! Aqui está um guia rápido para visitar São Paulo:

  ## Atrações
  - Avenida Paulista
  - Museu de Arte de São Paulo (MASP)
  - Parque Ibirapuera
  - Mercado Municipal de São Paulo

  ## Gastronomia
  - Pizza paulista
  - Pastel de feira
  - Sanduíche de mortadela do Mercado Municipal
  - Restaurantes internacionais e alta gastronomia

  ## Bairros
  - Jardins
  - Vila Madalena
  - Liberdade
  - Pinheiros

  ## Dicas
  - A cidade é grande, use metrô ou aplicativos de transporte
  - Aproveite a cena cultural e os museus
  - Explore bares e restaurantes na Vila Madalena
  - Visite feiras gastronômicas e mercados locais

  Pergunte-me qualquer coisa sobre atrações, gastronomia ou dicas de viagem!
  TEXT
  image_url: "https://images.unsplash.com/photo-1543059080-f9b1272213d5"
)

Trip.create!(
  city: "Minas Gerais",
  content: <<~TEXT,
    Bem-vindo! Aqui está um guia rápido para visitar Minas Gerais:

  ## Atrações
  - Ouro Preto (cidade histórica colonial)
  - Inhotim (um dos maiores museus de arte contemporânea a céu aberto do mundo)
  - Serra do Cipó
  - Capitólio e o Lago de Furnas

  ## Gastronomia
  - Pão de queijo
  - Feijão tropeiro
  - Frango com quiabo
  - Doce de leite mineiro

  ## Cidades e Regiões
  - Ouro Preto
  - Tiradentes
  - Belo Horizonte
  - Capitólio

  ## Dicas
  - Experimente a culinária mineira tradicional
  - Visite cidades históricas com arquitetura colonial
  - Explore cachoeiras e trilhas na Serra do Cipó
  - Reserve tempo para conhecer museus e centros culturais

  Pergunte-me qualquer coisa sobre atrações, gastronomia ou dicas de viagem!
  TEXT
  image_url: "https://images.unsplash.com/photo-1599940824399-b87987ceb72a"
)

puts "Seeds created!"
