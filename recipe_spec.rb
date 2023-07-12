require_relative 'recipe'

describe Recipe do
  before do
    Recipe.clear

    Recipe.describe do
      recipe 'Pancake' do
        ingredient 'Store-bought pancake mix'
        ingredient 'Water'

        steps do
          step 'Mix the ingredients'
          step 'Cook them in a pan'
        end
      end

      recipe 'Miso Soup' do
        ingredient 'Tofu'
        ingredient 'White miso paste'

        steps do
          step 'Mix miso paste into boiling water'
          step 'Add tofu and serve'
        end
      end
    end
  end

  it 'records the ingredients and method of each recipe' do
    pancake_recipe = Recipe.for('Pancake')

    expect(pancake_recipe.name).to eq 'Pancake'
    expect(pancake_recipe.ingredients).to eq ['Store-bought pancake mix', 'Water']
    expect(pancake_recipe.method_steps).to eq ['Mix the ingredients', 'Cook them in a pan']

    soup_recipe = Recipe.for('Miso Soup')

    expect(soup_recipe.name).to eq 'Miso Soup'
    expect(soup_recipe.ingredients).to eq ['Tofu', 'White miso paste']
    expect(soup_recipe.method_steps).to eq ['Mix miso paste into boiling water', 'Add tofu and serve']
  end

  it 'clears the recipes' do
    Recipe.clear

    expect(Recipe.for('Pancake')).to be_nil
    expect(Recipe.for('Miso Soup')).to be_nil
  end

  it 'returns nil for non-existing recipe' do
    non_existing_recipe = Recipe.for('Non-Existing Recipe')

    expect(non_existing_recipe).to be_nil
  end

  it 'adds ingredients correctly' do
    Recipe.describe do
      recipe 'Omelette' do
        ingredient 'Eggs'
        ingredient 'Milk'
        ingredient 'Salt'
        ingredient 'Pepper'
      end
    end

    omelette_recipe = Recipe.for('Omelette')

    expect(omelette_recipe.ingredients).to eq %w[Eggs Milk Salt Pepper]
  end

  it 'adds method steps correctly' do
    Recipe.describe do
      recipe 'Smoothie' do
        steps do
          step 'Add fruits to blender'
          step 'Add yogurt and milk'
          step 'Blend until smooth'
          step 'Serve chilled'
        end
      end
    end

    smoothie_recipe = Recipe.for('Smoothie')

    expect(smoothie_recipe.method_steps).to eq ['Add fruits to blender', 'Add yogurt and milk', 'Blend until smooth', 'Serve chilled']
  end
end
