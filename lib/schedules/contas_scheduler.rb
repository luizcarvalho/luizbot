require_relative '../../lib/modules/google/contas'

class ContasScheduler
  def initialize
    @last_notification_day = ENV['LAST_NOTIFICATION_DAY']
    @contas = Contas.new
  end

  def verify
    return unless notification_conditional
    format_message(@contas.close_bills_duedates)
  end

  def format_message(bills)
    return if bills.empty?

    message = message_header

    bills.each do |bill|
      message += "\n\n#{bill[:conta]} [#{bill[:row]}]\n" \
                "📆 Mês referência: #{bill[:mes]}\n⏳ Data de vencimento: #{bill[:vencimento]}\n"\
                "💲 Valor: #{bill[:valor]}\n"
      message += "🔢 Código de pagamento: `#{bill[:codigo]}`\n" if bill[:codigo]
      message += "🏧 Data de pagamento: #{bill[:pagamento]}\n" if bill[:pagamento]
    end
    message
  end

  def message_header
    "⚠️⚠️⚠️\nEiii seu veaco, bora pagar as contas né? Tão atrasadas!"
  end

  def notification_conditional
    Time.now.hour >= 8 && Time.now.hour <= 11
    true
  end
end
