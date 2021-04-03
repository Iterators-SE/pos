class BasePresenter<T> {
  T view;

  // ignore: use_setters_to_change_properties
  void attachView(T view) {
    this.view = view;
  }

  void detachView() => view = null;

  bool get isViewAttached {
    return view != null;
  }

  void checkViewAttached() {
    if (view == null) {
      throw Exception("attached view is null!");
    }
  }

  T getView() {
    return view;
  }
}
