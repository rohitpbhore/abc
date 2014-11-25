class User < ActiveRecord::Base
  has_many :articles

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
        user.articles.each do |article|
          csv << [article.text]
        end
      end
    end
  end
end
