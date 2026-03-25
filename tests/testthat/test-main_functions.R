test_that("findDE works", {
  skip_on_cran()
  set.seed(42)

  # default with sparse matrix input
  counts <- DElegate::pbmc$counts
  meta_data <- DElegate::pbmc$meta_data
  res <- findDE(object = counts, meta_data = meta_data, group_column = 'celltype')
})

test_that("findDE works with Seurat object", {
  skip_on_cran()
  skip_if_not_installed("Seurat")
  skip_if_not_installed("SeuratObject")
  set.seed(42)

  # Create a simple Seurat object
  counts <- DElegate::pbmc$counts
  meta_data <- DElegate::pbmc$meta_data
  obj <- SeuratObject::CreateSeuratObject(counts = counts, meta.data = meta_data)
  SeuratObject::Idents(obj) <- obj$celltype

  # Test findDE with Seurat object
  res <- findDE(object = obj)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) > 0)
  expect_true("feature" %in% colnames(res))
  expect_true("log_fc" %in% colnames(res))
  expect_true("pvalue" %in% colnames(res))
})
