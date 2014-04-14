class window.MLPerceptron
  c_hlayers: 1
  c_inputs: 0
  add_input_layer: ->
  add_hidden_layer: ->
    n = []
    w = []
    for i in [1..@c_inputs]
      n.push 0
      _w = []
      for j in [1..@c_inputs]
        _w.push Math.random()*.3+.1
      w.push _w

    @layers.push
      n: n
      w: w
  add_output_layer: ->
    n = []
    w = []
    for i in [1..@c_inputs]
      w.push Math.random()*.3+.1
    @layers.push
      n: [0]
      w: [w]

  init: (size) ->
    @c_inputs = size
    @layers = []
    @add_input_layer()
    @add_hidden_layer() for i in [1..@c_hlayers]
    @add_output_layer()
  learn: (patterns) -> 
    @init patterns[0][0].length
    console.log @layers[0].w[0], @layers[0].w[1], @layers[1].w[0]
    max_li = 5000
    li = 0
    while true
      gerror = 0
      for pattern in patterns
        res = @calc pattern[0]
        error = pattern[1] - res[0]
        gerror += Math.abs error
        errors = []
        for i in [0..@c_inputs-1]
          errors[i] = error*@layers[1].w[0][i]
        for i in [0..@c_inputs-1]
          for j in [0..@c_inputs-1]
            diff = .05*errors[j]*pattern[0][i]
            @layers[0].w[i][j] += diff
        for i in [0..@c_inputs-1]
          diff = .05*error*@layers[0].n[i]
          @layers[1].w[0][i] += diff
      li++
      break if (li > max_li) || (gerror is 0)
    if gerror
      console.log "Learning failed after #{li} iterations"
    else
      console.log "Learned in #{li} iterations"

  calc_layer: (layer, signal) ->
    for n, i in layer.n
      n = 0
      for s, j in signal
        n += s*layer.w[i][j]
      if n > .5 then layer.n[i] = 1 else layer.n[i] = 0
    layer.n

  calc: (signal) ->
    _signal = _.clone signal
    for layer, i in @layers
      _signal = @calc_layer layer, _signal
    @layers[@layers.length-1].n

