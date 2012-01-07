class Expression < ActiveRecord::Base

  validates :name, :presence => true, :length => {:maximum => 255}

  has_attached_file :image,
                    :styles => {
                        :tiny => "32x32",
                        :small => "64x64",
                        :medium => "200x200",
                        :original => "400x400",
                        :big => "600x600"
                    }

  belongs_to :collection

#  before save:
#  check if collection for this expression belongs to user (or nil - an universal collection )


# next expression, used in learning
  def next
    Expression.where('id > ?', self.id).order('id ASC').limit(1).first
  end

  # previous expression, used in learning
  def previous
    Expression.where('id < ?', self.id).order('id DESC').limit(1).first
  end

  # use this names in views of learn controller
  def self.list_of_attributes_to_learn
    ['image', 'definition', 'synonyms', 'examples', 'notes']
  end

end
