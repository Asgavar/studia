module type VERTEX =
sig
  type t
  type label
  val equal : t -> t -> bool
  val create : label -> t
  val label : t -> label
end


module type EDGE =
sig
  type t
  type vertex
  type label
  val equal : t -> t -> bool
  val from_vertex : t -> vertex
  val to_vertex : t -> vertex
end


module StringVertex : VERTEX =
struct
  type label = string
  type t = Vrtx of label
  let equal v1 v2 =
    match (v1, v2) with
      (Vrtx l1), (Vrtx l2) when l1 = l2 -> true
    | _ -> false
  let create lbl = Vrtx lbl
  let label vrtx = match vrtx with Vrtx lbl -> lbl
end


module StringEdge : (EDGE with type vertex = StringVertex.t) =
struct
  type vertex = StringVertex.t
  type t = Edge of vertex * vertex
  type label = string
  let equal e1 e2 =
    match (e1, e2) with
      (Edge (from1, to1), Edge (from2, to2)) when from1 = from2 && to1 = to2 -> true
    | _ -> false
  let from_vertex edge =
    match edge with
      Edge (from_vrtx, _) -> from_vrtx
  let to_vertex edge =
    match edge with
      Edge (_, to_vrtx) -> to_vrtx
end


module type GRAPH =
sig
(* typ reprezentacji grafu *)
type t
module V : VERTEX
type vertex = V.t
module E : EDGE
type edge = E.t

(* funkcje wyszukiwania *)
val mem_v : t -> vertex -> bool
val mem_e : t -> edge -> bool
val mem_e_v : t -> vertex -> vertex -> bool
val find_e : t -> vertex -> vertex -> edge
val succ : t -> vertex -> vertex list
val pred : t -> vertex -> vertex list
val succ_e : t -> vertex -> edge list
val pred_e : t -> vertex -> edge list

(* funkcje modyfikacji *)
val empty : t
val add_e : t -> edge -> t
val add_v : t -> vertex -> t
val rem_e : t -> edge -> t
val rem_v : t -> vertex -> t

(* iteratory *)
val fold_v : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
val fold_e : (edge -> 'a -> 'a) -> t -> 'a -> 'a
end


module Graph : GRAPH =
struct
  module V = StringVertex
  module E = StringEdge
  type t = {vertices : V.t list; edges : E.t list}
  type vertex = V.t
  type edge = E.t

  let mem_v graph v =
    List.mem v graph.vertices

  let mem_e graph e =
    List.mem e graph.edges

  let mem_e_v graph from_v to_v =
    not (List.filter (fun edge -> (E.from_vertex edge = from_v) && (E.to_vertex edge = to_v)) graph.edges = [])

  let rec find_e graph from_v to_v =
    match graph.edges with
    | [] -> failwith "w tym grafie nie ma takiej krawędzi!"
    | hd :: tl -> if E.from_vertex hd = from_v && E.to_vertex hd = to_v
      then hd
      else find_e {vertices=graph.vertices; edges=tl} from_v to_v

  let succ graph v =
    let rec aux edges_left successors =
      match edges_left with
      | [] -> successors
      | hd :: tl -> if E.from_vertex hd = v
        then aux tl (E.to_vertex hd :: successors)
        else aux tl successors
    in aux graph.edges []

  let pred graph v =
    let rec aux edges_left predecessors =
      match edges_left with
      | [] -> predecessors
      | hd :: tl -> if E.to_vertex hd = v
        then aux tl (E.from_vertex hd :: predecessors)
        else aux tl predecessors
    in aux graph.edges []

  let succ_e graph v =
    let rec aux edges_left successors =
      match edges_left with
      | [] -> successors
      | hd :: tl -> if E.from_vertex hd = v
        then aux tl (hd :: successors)
        else aux tl successors
    in aux graph.edges []

  let pred_e graph v =
    let rec aux edges_left predecessors =
      match edges_left with
      | [] -> predecessors
      | hd :: tl -> if E.to_vertex hd = v
        then aux tl (hd :: predecessors)
        else aux tl predecessors
    in aux graph.edges []

  let empty = {vertices=[]; edges=[]}

  let add_e graph e =
    {vertices=graph.vertices; edges=(e :: graph.edges)}

  let add_v graph v =
    {vertices=(v :: graph.vertices); edges=graph.edges}

  let rec list_rm x xs =
    match xs with
    | [] -> []
    | hd :: tl -> if hd = x
      then list_rm x tl
      else hd :: list_rm x tl

  let rem_e graph e =
    {vertices=graph.vertices; edges=(list_rm e graph.edges)}

  let rem_v graph v =
    {vertices=(list_rm v graph.vertices); edges=graph.edges}

  let fold_v func graph init =
    List.fold_right func graph.vertices init

  let fold_e func graph init =
    List.fold_right func graph.edges init
end
