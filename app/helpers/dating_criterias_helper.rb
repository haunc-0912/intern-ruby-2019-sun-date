module DatingCriteriasHelper
  def prefer_gender_list
    User.genders.keys.map do |gender|
      [
        t("signup.#{gender}"),
        Settings.gender.send(gender)
      ]
    end
  end
end
