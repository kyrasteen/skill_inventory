require_relative 'skill'
require 'yaml/store'

class SkillInventory
  def self.database
    @database ||= YAML::Store.new("db/skill_inventory")
  end

  def self.add(skill)
    database.transaction do
      database['counter'] ||= 0
      database['skills'] ||= []
      database['counter'] += 1
      database['skills'] << Skill.new(database['counter'], skill[:name], skill[:description])
    end
  end

  def self.raw_skills
    database.transaction do
      database['skills'] || []
    end
  end

  def self.all
    raw_skills
  end

  def self.find(id)
    all.find {|skill| skill.id == id}
  end

  def self.update(id, skill)
    database.transaction do
      found_skill = database['skills'].find { |skill| skill.id == id }
      found_skill.name = skill['name']
      found_skill.description = skill['description']
    end
  end
end
