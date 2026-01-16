(define (over-or-under num1 num2) 
  (cond ((< num1 num2) -1)
        ((= num1 num2) 0)
        ((> num1 num2) 1)
  )
)

(define (make-adder num)
  (lambda (inc) (+ num inc))
) 

(define (composed f g)
  (lambda (x) (f (g x)))
) 

(define (repeat f n) 
  (define (res x rest)
    (if (= rest 1)
      (f x)
      (res (f x) (- rest 1))
    )
  )
  (lambda (x) (res x n))
)

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b) 
  (let 
    ((smaller (min a b))
    (greater (max a b)))
    (if (zero? (modulo greater smaller))
      smaller
      (gcd smaller (modulo greater smaller))
    )
  )
)
