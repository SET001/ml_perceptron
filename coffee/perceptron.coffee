class window.Perceptron
  constructor: ->
    @weights = []
  foo: 0.1
  calc: (signal) ->
    wl = @weights.length

    if signal.length > wl
      i = 0
      while i<(signal.length / wl)
        r = signal.slice i*wl, i*wl+wl
        if r.length < wl
          for j in [1..(wl-r.length)]
            r.push 0
        console.log r
        i++

    sum = 0
    for s, i in signal
      sum += s*@weights[i]
    if sum>0.5 then return 1 else return 0

  learn: (templates) ->
    @weights = []
    for i in [1..templates[0][0].length]
      @weights.push Math.random()
    li = 0
    max_li = 50
    console.log @weights
    while true
      gerror = 0
      li++
      for template, i in templates
        res = @calc template[0]
        # console.log "result: #{res}"
        error = template[1] - res
        gerror += Math.abs error
        for weight, i in @weights
          @weights[i] += @foo*error*template[0][i]
      if ((gerror == 0) || li > max_li) then break
    if gerror == 0
      console.log "Learned in #{li} iterations"
    else
      console.log "Learning failed after #{max_li} iterations"
    console.log @weights
