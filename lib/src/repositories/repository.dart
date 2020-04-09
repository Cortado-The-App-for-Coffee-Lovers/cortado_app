abstract class Repository<T, K> {
  Future<List<T>> read();

  Future<T> readById(K id);
  create(T entity);
  update(T entity);
  delete(T entity);
}
