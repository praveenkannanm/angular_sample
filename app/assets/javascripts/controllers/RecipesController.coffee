controllers = angular.module('controllers',[])
controllers.controller("RecipesController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })
    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.recipes = []
    $scope.view = (recipeId)-> $location.path("/recipes/#{recipeId}")

])

controllers = angular.module('controllers')
controllers.controller("RecipeController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location,flash)->
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })
    Recipe.get({recipeId: $routeParams.recipeId},
      ( (recipe)-> $scope.recipe = recipe ),
      ( (httpResponse)->
        $scope.recipe = null
        flash.error   = "There is no recipe with ID #{$routeParams.recipeId}"
      )
    )
    $scope.back = -> $location.path("/")
])