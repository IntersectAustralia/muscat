# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.find_or_create_by name: 'admin'
Role.find_or_create_by name: 'editor'
Role.find_or_create_by name: 'cataloger'
Role.find_or_create_by name: 'guest'

# Add default admin user if no admins exist
admin_count = Role.find_by(name: 'admin').users.count
if admin_count == 0
  User.create!(name: 'Admin', email: 'admin@example.com', roles: [Role.first], password: 'password', password_confirmation: 'password')
end

CanonType.find_or_create_by(relationship_operator: 'ex', name: 'unison canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'double canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'triple canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'retrograde motion canon (cancrizans or crab canon)')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'contrary motion canon (inversion canon)')
CanonType.find_or_create_by(relationship_operator: 'to', name: 'proportional canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'mensuration canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'continuous canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'riddle canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'puzzle canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'enigmatic canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'resolved canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'invertible canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'stacked canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'octave transposition (parallel)')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'canon per tonos')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'interval canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'precusor canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'retrograde contrary motion canon')
CanonType.find_or_create_by(relationship_operator: '',   name: 'verbal canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'quadruple canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'parallel canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'perpetual canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'permutation canon')
CanonType.find_or_create_by(relationship_operator: 'ex', name: 'polymorphous canon')