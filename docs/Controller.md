# Controller

1. Run `bundle exec rails g scaffold post` to see sample controller for model `Post`

1. Keep `Controller` simple and thinny

### Route

1. use shadow routes (TODO)

### Endpoint

1. Use conventional endpoints (`index`, `create`, `update`, `show` and `destroy`) if possible

    > Provide GraphQL endpoints to replace `index` and `show` (TODO)

    > Reuse `create` on association for custom actions, e.g. replace `POST /api/v1/orders/:uuid/pay` with `POST /api/v1/orders/:uuid/payments` (TODO)

    > Reuse `update` for idempotent custom actions, e.g. replace `POST /api/v1/users/:uuid/activate` with `PATCH /api/v1/users/:uuid` with a virtual attribute `active` corresponding to `AASM` event (TODO)

1. Follow controller flow control conventions

    ~~~ruby
    def custom_action
      instance = Model.find_specific_instance
      if instance.perform_action(action_params)
        # successful
        render json: instance
      else
        # failed
        render json: { message: instance.error_attribute }, status: :bad_request
      end
    end
    ~~~

### Inheritance

1. isolate resource controller (e.g. `Api::V1::UsersController`), base controller (e.g. `Api::V1::BaseController`) and application controller (`::ApplicationController`)

    > Only move generic operations (e.g. rescue `404`) to application controller

    > Move sharable operations (e.g. auth) to base controller or move them to concerns/gems and include in base controller

### Params

1. use `params.require` to validate mandatory params, which throws `ActionController::ParameterMissing` and rescue in application controller

1. use `params.permit` to sanitize params

1. separate `create_model_params`, `update_model_params` and `custom_model_params`

### Association prerequisite

1. use `before_action` to `set_association` with assertion, which throws `ActiveRecord::RecordNotFound` and rescue in application controller

### Test

1. write `request` specs

    If we follow above rules, controllers are not likely to have bugs and there is no need for `controller` specs or `routing` specs

1. write one successful and one failed spec for each endpoint
