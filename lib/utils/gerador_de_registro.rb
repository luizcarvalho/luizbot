# Simple script to create a month sequence
# frozen_string_literal: true

meses = %w[JANEIRO FEVEREIRO MARÇO ABRIL MAIO JUNHO JULHO AGOSTO SETEMBRO OUTUBRO NOVEMBRO DEZEMBRO]

contas_string = %(
📱 CELULAR	20/01/2021
💧 AGUA	28/01/2021
💡 ENERGIA	02/02/2021
📶 INTERNET	05/02/2021
💳 CARTÃO 	05/02/2021
💡 ENERGIA PAI CS	13/01/2021
💡 ENERGIA PAI PS	11/02/2021
)

contas = []
contas_string.each_line do |line|
  nome, vencimento = line.split(%r{\s(\d{2}/\d{2}/\d{4})})
  contas << { nome: nome, vencimento: vencimento } if vencimento
end

datas_sequenciais = []

meses.each_with_index do |mes, mes_index|
  contas.each_with_index do |conta, i|
    d, m, a = conta[:vencimento].split('/')
    numero_mes = m.to_i + mes_index

    if numero_mes == 13
      numero_mes = '01'
      a = 2022
    end

    puts "#{mes}, #{conta[:nome]}, #{d}/#{numero_mes}/#{a}"
  end
end
