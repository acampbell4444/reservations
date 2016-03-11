require "rails_helper"

RSpec.describe UpdateReservationMailer, type: :mailer do
  describe "mailer" do
    let(:mail) { UpdateReservationMailer.mailer }

    it "renders the headers" do
      expect(mail.subject).to eq("Mailer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
