Factory.define :album do |f|
  f.sequence :title do |n|
    "Album #{n}"
  end
end
