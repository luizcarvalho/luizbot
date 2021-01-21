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

    bills.map do |bill|
      message = "⚠️ Conta prestes a vencer ou vencida ⚠️\n\n#{bill[:conta]} [#{bill[:row]}]\n" \
                "📆 Mês referência: #{bill[:mes]}\n"\
                "⏳ Data de vencimento: #{bill[:vencimento]}\n"\
                "💲 Valor: #{bill[:valor]}\n"
      message += "🔢 Código de pagamento: `#{bill[:codigo]}`\n" if bill[:codigo]
      message += "🏧 Data de pagamento: #{bill[:pagamento]}\n" if bill[:pagamento]

      message
    end
  end

  def notification_conditional
    @last_notification_day != Date.today.day
  end
end
