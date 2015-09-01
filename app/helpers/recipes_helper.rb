module RecipesHelper

  def get_voter_name(recipe)
    recipe.votes_for.up.by_type(User).voters.map{ |voter| voter.name }.join(', ')
  end

end
