Rails.application.routes.draw do
  match '/', to: 'options#show', format: false, :via => [:options,:get,:link]



  resources :words

  scope '/words' do
    scope '/:id' do
      match '/' => proc { [405, {}, ['']] }, via: :all
      scope 'edit'do
        match '/' => proc { [405, {}, ['']] }, via: :all
      end
    end
    match '/' => proc { [405, {}, ['']] }, via: :all
  end
  match '/'=> proc { [405, {}, ['']] }, via: :all
end
