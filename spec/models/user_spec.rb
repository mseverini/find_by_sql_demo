require 'rails_helper'

describe User do
  describe "active scope" do
    before { 3.times{ User.new.save }}
    it "has users" do
      expect(User.all.count).to be > 0
    end

    context "when there are active users" do
      before do
        user = User.last
        ActiveRecord::Base.connection.execute("INSERT INTO active_users (user_id, created_at, updated_at) VALUES (#{user.id}, '#{2.years.ago}', '#{2.years.ago}');")
      end

      it "scopes" do
        expect(User.active.count).to be 1
      end

      it "gets the right id" do
        expect(User.active.first.id).to be User.last.id
        expect(User.active.first.created_at).to be > 10.seconds.ago
        expect(User.active.first.updated_at).to be > 10.seconds.ago
      end
    end
  end

  describe "active_wrong scope" do
    before { 3.times{ User.new.save }}
    it "has users" do
      expect(User.all.count).to be > 0
    end

    context "when there are active users" do
      before do
        user = User.last
        ActiveRecord::Base.connection.execute("INSERT INTO active_users (user_id, created_at, updated_at) VALUES (#{user.id}, '#{2.years.ago}', '#{2.years.ago}');")
      end

      it "scopes" do
        expect(User.active_wrong.count).to be 1
      end

      it "gets the right id" do
        expect(User.active_wrong.first.id).to_not be User.last.id
        expect(User.active_wrong.first.created_at).to_not be > 10.seconds.ago
        expect(User.active_wrong.first.updated_at).to_not be > 10.seconds.ago
      end
    end
  end
end
