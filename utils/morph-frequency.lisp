;;; Morph-frequency
;;; (morph-frequency "arquivo-entrada" "arquivo-saida" tipo-de-dado)
;;; tipo-de-dado: significante, significado, ambos


;; Funções para abrir o arquivo e pegar os dados

;; Função para abrir o arquivo: (uiop:read-file-lines nome-do-arquivo)


;; Checar se os dados são válidos (tamanho da lista é múltiplo de tres)
(defun valida-dados (dados)
  (= (mod (length dados) 0)))

;; Filtra as linhas com significantes e as com significados
(defun filtra-linhas (dados tipo)
  (let ((linha 1))
    (when (eq tipo 'significado) (setf linha 2))
    (loop :for i :in dados
          :when (= (contador) linha)
          :collect i
          :end)))
          
; contador de três posições
(let ((count 0))
  (defun contador () 
    (if (= count 3)
        (setf count 1)
        (incf count))
    count))

;; Dividir linhas em morfemas
(defun dividir-em-morfes (linha)
  (let ((linha-p (substitute #\Space #\- linha)))
    (loop :for i = 0 :then (1+ j)
          :as j = (position #\Space linha-p :start i)
          :collect (subseq linha-p i j)
          :while j))
  )


;; Salvar os morfemas em hash-table
(defun contar-morfemas (dados)
  (let ((tabela (make-hash-table))
        (dados-p (dividir-em-morfes dados)))
    (loop :for i :in dados-p
          :do (loop :for m :in i
                    :do (if (gethash (read-from-string m) tabela)
                            (incf (gethash (read-from-string m) tabela))
                            (setf (gethash (read-from-string m) tabela) 1))))
    tabela))



