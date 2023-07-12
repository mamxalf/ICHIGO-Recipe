class Recipe
  attr_reader :name, :ingredients, :method_steps

  @recipes = {}

  def self.clear
    @recipes = {}
  end

  def self.describe(&block)
    instance_eval(&block)
  end

  def self.recipe(name, &block)
    recipe = Recipe.new(name)
    recipe.instance_eval(&block)
    @recipes[name] = recipe
  end

  def self.for(name)
    @recipes[name]
  end

  def initialize(name)
    @name = name
    @ingredients = []
    @method_steps = []
  end

  def ingredient(name)
    @ingredients << name
  end

  def steps(&block)
    instance_eval(&block)
  end

  def step(instruction)
    @method_steps << instruction
  end
end
