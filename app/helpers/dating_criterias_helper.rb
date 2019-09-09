module DatingCriteriasHelper
  def prefer_gender_list
    [:male, :female, :both_gender].map do |gender|
      [
        t("signup.#{gender}"),
        Settings.gender.send(gender)
      ]
    end
  end
end
