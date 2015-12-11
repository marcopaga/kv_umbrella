defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucketPid} = KV.Bucket.start_link
    {:ok, bucket: bucketPid, testProduct: "milk"}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", testContext do
    %{bucket: bucketPid} = testContext
    %{testProduct: product} = testContext
    KV.Bucket.put(bucketPid, product, 3)
    assert KV.Bucket.get(bucketPid, product) == 3
    KV.Bucket.delete(bucketPid, product)
    assert KV.Bucket.get(bucketPid, product) == nil
  end
end
