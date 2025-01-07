(ns release 
  (:require
    [cheshire.core :as json]
    [babashka.fs :as fs]))

(require '[cheshire.core :as json])
(require '[babashka.fs :as fs])
(require '[clojure.string :as str])
(def stx_release_root "/mnt/dat/i/prj/haxe/pub/ohmrun/stx_release")
(defn load [] (-> (slurp (str/join "/" [stx_release_root "sources.json"])) (json/parse-string)) )
(defn rm_stuff [] 
  (fs/delete-tree (str/join "/" [stx_release_root "src/main/haxe"])) 
  (fs/delete-tree (str/join "/" [stx_release_root "src/test/haxe"]))
  )

(defn handle [data]
  (let 
   [
    root (get data "root")
    directories (get data "directories")
    sep "/"
    src_path root
    parts (map (fn [dir] (str/join sep [src_path dir])) directories) 
    ]
    (rm_stuff)
    (prn (count parts))
    (doseq [part parts]
      (let 
       [main_part (str/join sep [part "src" "main" "haxe"])
        test_part (str/join sep [part "src" "test" "haxe"])
        ]
      (println part)
      (fs/copy-tree main_part "src/main/haxe")
      (fs/copy-tree test_part "src/test/haxe")
      ))
  )
)
(defn -main [& _args]
  (handle (load))
  )