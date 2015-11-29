class Alvid::Retro
  include DataMapper::Resource
  property :message,      String
  property :id,         Serial

  def self.add(message)
    create(message: message)
  end

  def self.list
    Alvid::Retro.all.map(&:message).join("\n")
  end

  def self.clear
    Alvid::Retro.destroy
  end
end

DataMapper.auto_upgrade!
