# frozen_string_literal: true

name 'fileutils'

run_list 'testutils::default'

cookbook 'fileutils', path: '.'
cookbook 'testutils', path: './test/fixtures/cookbooks/testutils'

Dir.children('./test/fixtures/cookbooks/testutils/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, "testutils::#{recipe_name}"
end
