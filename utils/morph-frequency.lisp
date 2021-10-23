;;; Morph-frequency
;;; (morph-frequency "arquivo-entrada")
;;; tipo-de-dado: significante, significado, ambos


(defun main ()
  (let ((comando nil))
    (loop
      :do (progn
            (setf sb-impl::*default-external-format* :utf-8)
            (format t "Digite o nome do arquivo ou 'sair': ")
            (force-output t)
            (setf comando (read-line t))
            (when (not (string= comando "sair")) 
              (if (morph-frequency comando)
                  (format t "Ok~%")
                  (format t "Algum problema ocorreu no arquivo~%"))))
      :when (string= comando "sair")
      :return comando)))

(defun morph-frequency (arquivo)
  (let ((dados (uiop:read-file-lines arquivo)))
    (if (valida-dados dados)
        (progn
          (imprimir-morfemas
           (contar-morfemas
            (dividir-em-morfes
             (filtra-linhas dados 'significado)))
           (concatenate 'string arquivo "-out-significado"))
          (imprimir-morfemas
           (contar-morfemas
            (dividir-em-morfes
             (filtra-linhas dados 'significante)))
           (concatenate 'string arquivo "-out-significante"))
          t)
        nil)))

;; Funções para abrir o arquivo e pegar os dados

;; Função para abrir o arquivo: (uiop:read-file-lines nome-do-arquivo)


;; Checar se os dados são válidos (tamanho da lista é múltiplo de tres)


(defun valida-dados (dados)
  (= (mod (length dados) 0)))

    ;; Filtra as linhas com significantes e as com significados



(defun filtra-linhas (dados tipo)
  (let ((indice 0)
        (dados-filtrado nil))
    (when (eql tipo 'significado) (setf indice 1))
    (dotimes (i (/ (length dados) 3))
      (setf dados-filtrado
            (cons (elt dados indice) dados-filtrado))
      (setf indice (+ indice 3)))
    dados-filtrado))
          

;; Dividir linhas em morfemas
(defun dividir-em-morfes (dados)
  (let ((morfes nil))
    (loop :for l in dados
          :do (let ((linha-processada (substitute #\Space #\- l)))
                (loop :for i = 0 :then (1+ j)
                      :as j = (position #\Space linha-processada :start i)
                      :do (setf morfes (cons (subseq linha-processada i j) morfes))
                      :while j)))
    morfes))


;; Salvar os morfemas em hash-table
(defun contar-morfemas (dados)
  (let ((tabela (make-hash-table))
        (morfes (dividir-em-morfes dados)))
    (loop :for i :in morfes
          :do (if (gethash (intern i) tabela)
                  (incf (gethash (intern i) tabela))
                  (setf (gethash (intern i) tabela) 1)))
    tabela))

;; Imprimir os morfemas com a contagem
(defun imprimir-morfemas (hash nome-arquivo)
  (with-open-file (output (concatenate 'string nome-arquivo ".csv")
                          :direction         :output
                          :if-does-not-exist :create
                          :if-exists         :supersede)
    (format output "morfema,contagem~%")
    (loop for k
          being the hash-key
          using (hash-value v) of hash
          do (format output "~a,~a~%" k v))))

