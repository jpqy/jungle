require "rails_helper"

RSpec.describe User, type: :model do
  subject {
    described_class.new(first_name: "John",
                        last_name: "Doe",
                        email: "john@doe.com",
                        password: "password",
                        password_confirmation: "password")
  }

  describe "Validations" do
    it "is valid with filled attributes" do
      expect(subject).to be_valid
    end

    it "must have first_name field" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "must have last_name field" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "must have password field" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "must have password_confirmation field" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "must have email field" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "must have matching password and password_confirmation" do
      subject.password = "password1"
      subject.password_confirmation = "password2"
      expect(subject).to_not be_valid
    end

    it "must have unique email that is case-insensitive" do
      subject.save

      user_with_same_email = User.new(first_name: "John",
                                      last_name: "Doe",
                                      email: "JOHN@DOE.COM",
                                      password: "password",
                                      password_confirmation: "password")

      expect(user_with_same_email).to_not be_valid
    end

    it "must have password length of 8 characters or more" do
      subject.password = "1234567"
      subject.password_confirmation = "1234567"
      expect(subject).to_not be_valid

      subject.password = "1234567"
      subject.password_confirmation = "1234567"
      expect(subject).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it "authenticates if email and password are correct" do
      subject.save
      correct_user = User.authenticate_with_credentials("john@doe.com", "password")
      expect(correct_user).to_not be_nil
      incorrect_user = User.authenticate_with_credentials("john@doe.com", "wrongpassword")
      expect(incorrect_user).to be_nil
    end
  end
end
