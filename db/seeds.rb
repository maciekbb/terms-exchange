# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

days = %w[monday tuesday wednesday thursday friday]
days.each do |name|
	Day.create(name: name)
end

subjects = ["BO", "Kompilatory", "Mikroprocki", "Sieci", "Symboliczne II", "TO", "TOiZO", "TW"]
hours = (1..12).to_a.map(&:to_s)
minutes = ["0", "30"]
j = 0 # user counter

100.times do 
	u = User.create(email: "nobody#{j}@example.com", password: "secret123#{j}")
	j+= 1
end

subjects.each do |name|
	s = Subject.create(name: name)
	hours.shuffle!
	i = 0 # hour counter
	5.times do 
		t = Term.create(hour: "#{hours[i]}:#{minutes[rand(1)]}", subject: s, day: Day.all.sample)
		i += 1
		10.times do 
			u = User.all.sample
			10.times do 
				Proposal.create(term: t, user: u, reason: "Another reason...", preferred: rand(10)==0)
			end
		end
	end
end