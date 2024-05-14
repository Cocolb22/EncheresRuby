pin "application", preload: true
pin 'popper', to: 'popper.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin_all_from 'app/javascript/src', under: 'src', to: 'src'
