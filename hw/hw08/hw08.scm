(define (ascending? s) 
    (define (find pre cur_s)
        (cond
            ((null? cur_s)
                #t
            )
            ((or (< pre (car cur_s)) (= pre (car cur_s)))
                (find (car cur_s) (cdr cur_s))
            )
            (else
                #f
            )
        )
    )
    (cond
        ((or (null? s) (null? (cdr s)))
            #t
        )
        (else
            (find (car s) (cdr s))
        )
    )
)

(define (my-filter pred s)
    (define init-list '())
    (define (res s-tail new-list) 
        (cond 
        ((null? s-tail) new-list)
        ((pred (car s-tail)) 
            (res (cdr s-tail) (append new-list (list(car s-tail)))))
        (else (res (cdr s-tail) new-list))))
    (res s init-list)
)

(define (interleave lst1 lst2) 
    (define (res s1 s2 new-lst)
        (cond
            ((or (null? s1) (null? s2)) 
                (append new-lst s1 s2)
            )
            (else
                (append new-lst (list (car s1)) (list (car s2))
                 (res (cdr s1) (cdr s2) '())
                )
            )
        )
    )
    (res lst1 lst2 '())
)

(define (no-repeats s) 
    (define (iter cur dict)
        (cond 
            ((null? cur)
                dict
            )
            ((null? (filter (lambda (x) (= x (car cur))) dict))
                (iter (cdr cur) (append dict (list (car cur))))
            )
            (else
                (iter (cdr cur) dict)
            )
        )
    )
    (iter s '())
)
