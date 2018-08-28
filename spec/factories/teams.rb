FactoryBot.define do
  factory :team do
    name "MyString"
    account nil
    timezone "MyString"
    has_reminder false
    has_recap false
    hash_id "MyString"
    reminder_time "2018-08-28 14:40:16"
    recap_time "2018-08-28 14:40:16"
  end
end
