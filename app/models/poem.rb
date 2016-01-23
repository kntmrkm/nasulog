# == Schema Information
#
# Table name: poems
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  title            :string(255)
#  description      :text(65535)
#  show             :boolean
#  original_poem_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Poem < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :original_poem, class_name: 'Poem'

  delegate :icon_url, to: :user
  delegate :name, to: :user, prefix: :author

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true

  def quote_original_poem
    if original_poem
      self.title = "RP: #{original_poem.title}"
      self.description =
        original_poem.description.gsub(/^/, '> ').gsub(/\A/, "\r\n\r\n\r\n")
    end
  end

end
