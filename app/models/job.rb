class Job < Post

  SEEK = "seek"
  HIRE = "hire"

  validates_inclusion_of :category, :in => [SEEK,HIRE], :message => 'Invalid category'
  
end
